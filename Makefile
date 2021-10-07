VIRT = virtual_environment

requires: linux_packages.txt
        sudo apt-get update -y
        sudo apt-get install -y `awk '{print $1}' linux_packages.txt`

virt_env: python_requirements.txt
        python3 -m venv $(VIRT)
        . $(VIRT)/bin/activate
        $(VIRT)/bin/pip3 install -r python_requirements.txt

run: cities_metadata.py weather_app.py
        @$(VIRT)/bin/python3 weather_app.py

clean:
	rm -rf $(VIRT)/__pycache__
	rm -rf $(VIRT)
