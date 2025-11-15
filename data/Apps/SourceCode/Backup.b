#!/usr/bin/zsh

Printer() {
	s=$1;
	c=$2;

	for i in {1..$c}; do
		echo -n "$s";
	done
	echo;
    unset s;
    unset c;
}

Main() {
	(
		cd ~;

        local timedate=$(env TZ='Europe/Prague' date +"%Y-%m-%d-%Hh%Mm");
		local user=$(whoami);
		
		local uncomplateDir=uncomplated-$user-$timedate;
		local compliateDir=$user-$timedate;
		local screenWidth=$COLUMNS;
		
		if [[ $1 ]]; then
			local savePath=$1;
		else
			local savePath=$myData/LinuxBackup;
		fi

		EXCLUDES=(		
			'data/LinuxBackup/uncomplate*'
			'*.swp'
			'.gnupg/S.gpg-agent*'
			'.cache/gvfsd/*'
		)
		
		TAR_ARGS=()
		for EXCLUDE in "${EXCLUDES[@]}"; do
		    TAR_ARGS+=(--exclude="$EXCLUDE")
		done

#		tar \
#		"${TAR_ARGS[@]}" \
#		-c \
#		--verbose \
#		--gzip \
#		--preserve-permissions \
#		--same-owner \
#		-f \
#		$savePath/$uncomplateDir .;
#
#		mv $savePath/$uncomplateDir $savePath/$compliateDir.tar.gz;
		
		echo "\n";
		Printer "=" $screenWidth;
		echo "Backup done in $savePath/$compliateDir.tar.gz";
		Printer "=" $screenWidth;
	)
	unset TAR_ARGS;
    unset EXCLUDES;
    unset EXCLUDE;
}

Main $1;
