pipeline {
  agent any
  stages {
    stage('Build') {
      agent {
        node {
          label 'dind'
        }

      }
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            sh 'docker build -t chronicc/jenkins-agend-dind:${BRANCH_NAME} .'
            sh 'docker login -u $USERNAME -p $PASSWORD'
            sh 'docker push chronicc/jenkins-agend-dind:${BRANCH_NAME}'
          }
        }
      }
    }

  }
}

