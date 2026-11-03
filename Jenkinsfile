pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'docker build --build-arg COLOR=green -t myapp:v2 .'
        sh 'docker save myapp:v2 -o v2.tar && chmod 644 v2.tar && sudo -u ubuntu minikube image load $WORKSPACE/v2.tar'
      }
    }
    stage('Deploy Green') {
      steps {
        sh 'kubectl apply -f deployment-green.yaml'
        sh 'kubectl rollout status deployment/myapp-green --timeout=120s'
      }
    }
    stage('Switch Traffic') {
      steps {
        input "Switch to Green?"
        sh '''
        kubectl patch service myapp-service \
        -p '{"spec":{"selector":{"app":"myapp","color":"green"}}}'
        '''
        sh 'kubectl get svc myapp-service -o jsonpath="{.spec.selector}"; echo'
      }
    }
  }
}
