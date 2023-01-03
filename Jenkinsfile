pipeline {
	agent any
	stages {
		stage("Compile") {
			steps {
				dir("calculator"){
					sh "JAVA_HOME='/usr/lib/jvm/java-17-openjdk-amd64' mvn compile"
				}
			}
		}
		stage("Unit test") {
			steps { 
				dir("calculator"){
					sh "JAVA_HOME='/usr/lib/jvm/java-17-openjdk-amd64' mvn test"
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
	}
}
