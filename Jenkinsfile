pipeline {
    agent any
    
    stages{
        stage("Clon code"){
            steps {
                echo "Cloneing the code"
                git url:"https://github.com/Quvonchdev/django-node-app.git", branch: "main"
            }
        }
        stage("build"){
            steps {
                echo "Build the image"
                sh "docker build -t my-node-app ."
            }
            
        }
        stage("Push to Docker Hub"){
            steps {
                echo "Pushing the image to docker hub"
                withCredentials([usernamePassword(credentialsId:"dockerhub",passwordVariable:"dockerhubPass",usernameVariable:"dockerhubUser")]){
                sh "docker tag my-node-app ${env.dockerhubUser}/django-node-cicd:latest"
                sh "docker login -u ${env.dockerhubUser} -p ${env.dockerhubPass}"
                sh "docker push ${env.dockerhubUser}/django-node-cicd:latest"
                }
            }
            
        }
        stage("Deploy"){
            steps {
                echo "Deploy the container"
                sh "docker run -d -p 8000:8000 quvonchdev/django-node-cicd:latest"
            }
            
        }
    }
}
