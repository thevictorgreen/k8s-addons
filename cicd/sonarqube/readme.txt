1:  Create namespace sonarqube
    kubectl apply -f namespace.yaml
    kubectl get ns

2:  Generate base64 encoded password for mysql database user root
    echo -n 'password' | base64

3:  Copy base64 encoded password into the password field in db.yaml 

4:  Create mysql database server
    kubectl -n sonarqube apply -f db.yaml

5:  Create mysql database client pod
    kubectl -n sonarqube apply -f utility-pod.yaml

6:  Connect to mysql databse server using the mysql client and create sonar database
    kubectl -n sonarqube exec --stdin --tty mysql-client -- /bin/sh
    mysql -h msvc1-db-service -ppassword-here
    show databases;
    create database sonar;

7:  Create sonarqube servcie, deployment and pvcs
    kubectl -n sonarqube apply -f app.yaml

8:  Verify startup
    kubectl -n sonarqube get pods
    kubectl -n sonarqube logs -f <pod_name>

9:  log into instance with the following creds
    username: admin
    password: admin

10: Create a new user
 
11: Create a token associated with this user
    Token can be used in Jenkins CI to scan code

12: Install SonarQube Scanner for Jenkins

13: Configure SonarQube Scanner in Global Tool Configuration
    Name: sonar
    Install Automatically
    Add Installer

14: Add Token to Jenkins Credentials
    Type : secret text
    Secret: token here
    ID : sonar
    Description : sonar

15: Can be used in Jenkins Pipeline like this
    def sonarqubeScannerHome = tool name: 'sonar', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
        println("SonarhomeInst:" + sonarqubeScannerHome)
        withCredentials([string(credentialsId: 'sonar', variable: 'sonarLogin')]) {
          sh "${sonarqubeScannerHome}/bin/sonar-scanner -e -Dsonar.host.url=http://k8smaster000.management.skyfall.io:30001 -Dsonar.login=$sonarLogin -Dsonar.projectName=horsefly-accounts -Dsonar.projectVersion=${commit_id} -Dsonar.projectKey=horsefly-accounts -Dsonar.sources=app/ -Dsonar.language=js"
        }
    
