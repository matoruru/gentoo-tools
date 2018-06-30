echo "[Install fish theme:]"

# check whether fish and its config dir exist or not
if [ ! -f /bin/fish ]; then
   echo fish does not exist!
   exit
fi
if [ ! -d ~/.config/fish ]; then
   echo ~/.config/fish does not exist!
   exit
fi

if [ ! -d ~/repositories ]; then
   echo ~/repositories dir does not exist!
   exit
fi


echo fish and its config dir exist!
echo continue installing fisherman...
echo

echo "   [Install fisherman:]"
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

echo "   [Install yimmy theme:]"
if [ -d ~/repositories/theme-yimmy ]; then
   echo timmy is installed already!
   exit
fi
cd ~/repositories
git clone https://github.com/oh-my-fish/theme-yimmy.git
echo                                                 >> ~/.fishrc
echo '# Set yimmy theme'                             >> ~/.fishrc
echo '. ~/repositories/theme-yimmy/fish_prompt.fish' >> ~/.fishrc
