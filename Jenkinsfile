pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage('Information') {
            steps {
                sh  'cat /etc/issue'
                sh  '''
                    printenv
                    uname -a
                    '''
            }
        }
    }
}

