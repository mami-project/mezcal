if [ ! -f .run_pathspider_complete ] ; do
    killall pspdr 
    bash ./upload_pathspider.sh
done

poweroff
