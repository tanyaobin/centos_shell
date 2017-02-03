#! /bin/bash
GRADLE_VERSION=3.3

if [[ $EUID -ne 0 ]] # Check if we're root. If we are, continue.
then
  sudo true
  SUDO="sudo"
  if [[ $? -ne 0 ]]
  then
    echo "ERROR: You must be able to sudo to run this script, or run it as root.";
    exit 1
  fi

fi

GRADLE_BIN_FILE="gradle-${GRADLE_VERSION}-bin.zip"
cd /opt
sudo wget https://services.gradle.org/distributions/${GRADLE_BIN_FILE}
sudo unzip ${GRADLE_BIN_FILE}

if [ -e gradle ]
then
  $SUDO rm gradle
fi
$SUDO ln -s gradle gradle-${GRADLE_VERSION}

if [ ! -e /etc/profile.d/gradle.sh ]
then
  sudo printf "export GRADLE_HOME=/opt/gradle\nexport PATH=\$PATH:\$GRADLE_HOME/bin" > /etc/profile.d/gradle.sh
fi
