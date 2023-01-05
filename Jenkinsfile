pipeline {
	agent{
		node{
			label 'jenkins_agent'
		}
	}	
	stages {
		stage("Compile") {
			steps {
				sh "whoami"
				dir("calculator"){
					sh "sudo JAVA_HOME='/usr/lib/jvm/java-17-openjdk-amd64' ./mvnw compile"
				}
			}
		}
		stage("Unit test") {
			steps { 
				dir("calculator"){
					sh "sudo JAVA_HOME='/usr/lib/jvm/java-17-openjdk-amd64' ./mvnw test"
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
					sh "sudo JAVA_HOME='/usr/lib/jvm/java-17-openjdk-amd64' ./mvnw checkstyle:checkstyle"
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
					sh "sudo JAVA_HOME='/usr/lib/jvm/java-17-openjdk-amd64' ./mvnw package"
				}
			}
		}
		stage("Docker build") {
			steps {
				sh "docker build -t josetello26/calculator:latest ."
			}
		}
		stage("Docker push") {
			steps {
				sh "docker tag calculador josetello26/calculator:latest"
				sh "docker push josetello26/calculator:latest"
			}
		}
		stage("Deploy to staging") {
			steps {
				sh "docker run -d --rm -p 8765:8080 --name calculator josetello26/calculator:latest"
			}
		}
		stage("Acceptance test") {
			steps {
				sleep 60
				sh "chmod +x acceptance_test.sh && ./acceptance_test.sh"
			}
		}
	}
	post {
		always {
			sh "docker stop calculator"
		}
	}
}
