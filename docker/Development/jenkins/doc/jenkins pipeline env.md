pipeline { 
    agent none

    environment {
        codePath = "/root/docker/DevOps/jenkins/jenkins_home/workspace/FlowTea/FlowTea-Dev/code"
        appVersion="1.1.0.18"
        ns="dev-flowtea"
        deployPath="/root/docker/dev/flowtea"
    }
    stages {
        stage('init env') { 
            agent any 
            steps {
                timeout(10) {
                    script { 
                        inputData = input message: "deploy flowtea to $ns,please text appVersion", ok: 'Proceed?', parameters: [string(defaultValue: '', description: 'text appVersion', name: 'appVersion')], submitterParameter: 'APPROVER' 
                    } 
                }
            } 
        }

        stage('deploy') { 
            agent any 
	    
            environment {
                appVersion="${inputData['appVersion']}"
            }

            steps {
                echo "deploy: $appVersion"

                sh "chroot /host bash -c 'set -e; cd $codePath/Publish/DevOps/jenkins-bash-dev;bash 80.deploy.sh;'"
            } 
        }
    } 
} 