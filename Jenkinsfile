
pipeline {
  agent {
    kubernetes {
      label 'taaspod'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: taas-jenkins-slave
  annotations:
    iam.amazonaws.com/role: arn:aws:iam::884956725745:role/taas-NodeInstanceRole-1P30OR4Q5QLT3
spec:
  containers:
  - name: taas
    image: kliu17/taas:taas_docker_image_2019_1_15_4
    env:
      - name: AWS_ACCESS_KEY_ID
        valueFrom:
          configMapKeyRef:
            name: eks-special-config
            key: aws_access_key_id
      - name: AWS_SECRET_ACCESS_KEY
        valueFrom:
          configMapKeyRef:
            name: eks-special-config
            key: aws_secret_access_key
    command:
    - cat
    tty: true
"""
    }
  }

  environment {
        AWS_REGION = 'us-east-1'
  }

  stages {
    stage('build') {
      steps {
        container('taas') {
          sshagent (credentials: ['taas-ssh']) {
            sh 'inspec version'
            sh 'bundle exec kitchen'
            sh 'aws --version'
            sh 'aws eks update-kubeconfig --name taas --region us-east-1'
            sh 'kubectl version'
            sh 'helm init'
	    sh 'git clone https://github.com/kliu17/taas-integration-tests /tmp/taas-integration-tests'
            sh "inspec exec /tmp/taas-integration-tests/profile/controls/ --reporter cli json:$BUILD_NUMBER/json/taas-integration.output.json junit:$BUILD_NUMBER/junitreport/taas-integration.junit.xml html:$BUILD_NUMBER/www/taas-integration.index.html || true"
            sh "/es_loader.sh store-elasticsearch-client $BUILD_NUMBER/json/taas-integration.output.json"
         }
        }
      }
   post {
  always {
	archiveArtifacts artifacts: '$BUILD_NUMBER/*/*', fingerprint: true
        // publish html
        publishHTML target: [
            allowMissing: false,
            alwaysLinkToLastBuild: false,
            keepAll: true,
            reportDir: '$BUILD_NUMBER/www',
            reportFiles: '*.index.html',
            reportName: 'TaaS HTML Report'
          ]
        junit "$BUILD_NUMBER/junitreport/*.xml"
  }

    }

}
  }

}
