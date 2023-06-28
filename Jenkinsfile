pipeline {
    agent {
        label 'worker'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], userRemoteConfigs: [[url: 'https://github.com/venkatrajana11/Jenkins-Project.git']]])
            }
        }
        
        stage('Build and Publish') {
            steps {
                script {
                    sh '''
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 978313412435.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t assignment-venkat .
                    docker tag assignment-venkat:latest 978313412435.dkr.ecr.us-east-1.amazonaws.com/assignment-venkat:$BUILD_NUMBER
                    docker push 978313412435.dkr.ecr.us-east-1.amazonaws.com/assignment-venkat:$BUILD_NUMBER
                    '''
                }
            }
        }

        stage('Cleanup the Docker Images') {
            steps {
                script {
                    sh 'docker rmi 978313412435.dkr.ecr.us-east-1.amazonaws.com/assignment-venkat:$BUILD_NUMBER'
                    sh 'docker rmi assignment-venkat:latest'
                    sh 'docker system prune -f'
                }
            }
        }    

        stage('Deploy to application') {
            steps {
                script {
                    sh '''
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 978313412435.dkr.ecr.us-east-1.amazonaws.com
                    docker pull 978313412435.dkr.ecr.us-east-1.amazonaws.com/assignment-venkat:$BUILD_NUMBER
                    docker run -itd -p 8081:8081 978313412435.dkr.ecr.us-east-1.amazonaws.com/assignment-venkat:$BUILD_NUMBER
                    '''
                }
            }
        }
    }
}
