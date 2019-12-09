1 Download HELM CLI
https://github.com/helm/helm/releases/tag/v2.15.0

2. Download the ZIP or TAR for your OS
   and extract in C:\helm folder

3. Update your PATH 
	set PATH=%PATH%;C:\helm\Windows-ADM64\helm.exe

4. One time setup:
	helm init

	- Make sure you have ~/.kube/config file
	- Make sure you have installed kubectl
	- your config should have ADMIN access cluster

5. Basic Command:
	$ helm version
	$ helm repo list
	$ helm search mongodb
	$ helm fetch stable/mongodb --untar=true

	# run this command from parent directory
1. By chart reference: helm install stable/mariadb
2. By path to a packaged chart: helm install ./nginx-1.2.3.tgz
3. By path to an unpacked chart directory: helm install ./nginx
4. By absolute URL: helm install https://example.com/charts/nginx-1.2.3.tgz
5. By chart reference and repo url: helm install --repo https://example.com/charts/ nginx

