if [ -z "$CAPP_BUILD" ]; then
	echo "PLEASE define CAPP_BUILD, for ex:";
	echo "   export CAPP_BUILD=$HOME/proj/cappuccino/build";
	exit 1;
fi

CONFIG=Debug jake && jake
