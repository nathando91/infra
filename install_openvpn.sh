#!/bin/bash

# Cập nhật hệ thống và cài đặt OpenVPN và easy-rsa
apt-get update && apt-get upgrade -y
apt-get install openvpn easy-rsa -y

# Thiết lập CA và chứng chỉ
make-cadir ~/openvpn-ca
cd ~/openvpn-ca

# Cấu hình các biến môi trường cho easy-rsa (Điều này cần được tùy chỉnh)
# Ví dụ: echo "set_var EASYRSA_REQ_COUNTRY    "VN"" >> vars
# Lặp lại dòng trên với các biến khác như EASYRSA_REQ_PROVINCE, EASYRSA_REQ_CITY, v.v.

# Khởi tạo PKI và xây dựng CA
source vars
./clean-all
./build-ca --batch

# Tạo chứng chỉ và khóa cho server
./build-key-server --batch server
./build-dh
openvpn --genkey --secret keys/ta.key

# Sao chép các file cấu hình mẫu và chứng chỉ vào thư mục OpenVPN
gunzip -c /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz > /etc/openvpn/server.conf
# Bạn có thể cần chỉnh sửa file server.conf để phản ánh đúng các thiết lập và khóa của bạn

# Khởi động OpenVPN
systemctl start openvpn@server
systemctl enable openvpn@server

# Cấu hình tường lửa và IP forwarding (Cần tùy chỉnh theo môi trường của bạn)
# Ví dụ: echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
# sysctl -p

echo "Cài đặt OpenVPN hoàn tất."
