pipeline {
    agent any
    stages {
        stage("test") {
            steps {
                timeout(time: 1, unit: 'MINUTES') {
                script {
                    env.DEPLOY_ENV = input message: '选择部署的环境', ok: 'deploy',
                        parameters: [choice(name: 'DEPLOY_ENV', choices: ['prd', 'uat', 'test'], description: '选择部署环境')]

                        switch("${env.DEPLOY_ENV}"){
                            case 'prd':
                                println('deploy prd env')
                                break;

                            case 'uat':
                                println('deploy uat env')
                                break;

                            case 'test':
                                println('deploy test env')
                                break;
                            
                            default:
                                println('error env')

                        }
                    }
                }
            }
        }
    }
}
