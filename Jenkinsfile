pipeline {
	agent any
	stages {
		stage("Compile") {
			steps {
				dir("calculator"){
					sh "kubectl config get-contexts"
					sh "chmod +x mvnw"
					sh "./mvnw compile"
				}
			}
		}
		stage("Unit test") {
			steps { 
				sh "whoami"
				dir("calculator"){
					sh "./mvnw test"
				}
			}
		}
		stage("Code coverage") {
			steps {
				publishHTML (target: [
					reportDir: 'calculator/target/site/jacoco',
					reportFiles: 'index.html',
					reportName:"JaCoCo Report"
				])
			}
		}
		stage("Static code analysis") {
			steps {

				dir("calculator"){
					sh "./mvnw checkstyle:checkstyle"
				}
				publishHTML (target: [
					reportDir: 'calculator/target/site',
					reportFiles: 'checkstyle.html',
					reportName:"Checkstyle Report"
				])
			}
		}
		stage("Package") {
			steps {
				dir("calculator"){
					sh "./mvnw package"
				}
			}
		}
		stage("Docker build") {
			steps {
				sh "docker build -t josetello26/calculator:${BUILD_TIMESTAMP} ."
			}
		}
		stage("Docker push") {
			steps {
				sh "docker tag calculador josetello26/calculator:${BUILD_TIMESTAMP}"
				sh "docker push josetello26/calculator:${BUILD_TIMESTAMP}"
			}
		}
		stage("Deploy to staging") {
			steps {
				sh "kubectl config get-contexts"
				sh "kubectl config use-context staging"
				sh "kubectl apply -f hazelcast.yaml"
				sh "kubectl apply -f deployment.yaml"
				sh "kubectl apply -f service.yaml"
			}
		}

		stage("Acceptance test") {
			steps {
				sleep 60
				sh "chmod +x acceptance_test1.sh && ./acceptance_test1.sh"
			}
		}
		stage("Release") {
			steps {
				sh "kubectl config use-context production"
				sh "kubectl apply -f hazelcast.yaml"
				sh "kubectl apply -f deployment.yaml"
				sh "kubectl apply -f service.yaml"
			}
		}
	}
	post {
		always {
			sh "docker stop calculator"
		}
	}
}
