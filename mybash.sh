for i in {1..16}; do
    google-chrome --profile-directory="Profile $i" "https://chromewebstore.google.com/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn" &
done

for i in {1..16}; do
    google-chrome --profile-directory="Profile $i" "https://chromewebstore.google.com/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif" &
done
for i in {1..16}; do
    google-chrome --profile-directory="Profile $i" "https://chainlist.org/chain/81457" &
done
