node {
  try {
    stage('Checkout') {
      checkout scm
    }
    stage('Environment') {
      sh 'git --version'
      echo "Branch: ${env.BRANCH_NAME}"
      sh 'docker -v'
      sh 'printenv'
    }
    stage('Build Docker test'){
     sh 'docker build -t django_pruebas-test -f Dockerfile.test --no-cache -v result:/results .'
    }
    stage('Docker test'){
      sh 'docker run --rm django_pruebas-test python3 pruebas/manage.py test'
    }
    stage('Clean Docker test'){
      sh 'docker rmi django_pruebas-test'
    }
    stage('Deploy'){
      if(env.BRANCH_NAME == 'master'){
        sh 'docker build -t django_pruebas-app --no-cache .'
//        sh 'docker tag react-app localhost:5000/react-app'
//        sh 'docker push localhost:5000/react-app'
//        sh 'docker rmi -f react-app localhost:5000/react-app'
      }
    }
  }
  catch (err) {
    throw err
  }
}
