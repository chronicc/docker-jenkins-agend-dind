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
        sh 'make pull'
        sh 'make build'
        sh 'make tag'
        script {
          withCredentials([
            usernamePassword(credentialsId: 'dockerhub_credentials',
            usernameVariable: 'USERNAME',
            passwordVariable: 'PASSWORD')
          ]) {
            sh 'make login REGISTRY_USERNAME=USERNAME REGISTRY_PASSWORD=PASSWORD'
          }
        }
        sh 'make push'
      }
    }

  }
}

