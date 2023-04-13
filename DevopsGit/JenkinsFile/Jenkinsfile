//SCRIPTED  old aproarch

// node{
//     echo('Build')
//     echo('Test')
//     echo('Integration Test')
// }

// node {
//     stage('Build') {
//         echo "Build"
//     }

//     stage('Test') {
//        echo "Test"
//     }

//     stage('Integration Test') {
//         echo "Integration Test"
//     }
// }



//DECLARATIVE

// pipeline {
//      agent any
//     // agent { docker { image  'maven:3.6.3'} }
//     // agent { docker { image  'node:13.8'} }
//     environment {
//         dockerHome = tool 'myDocker'
//         mavenHome =  tool 'myMaven'
//         PATH = "$dockerHome/bin:$mavenHome/bin:$PATH"
//     }



//     stages{
//         stage('Build') {
//             steps {
//                 // sh 'mvn --version'
               
//                 bat 'cd'
//                 // sh 'pwd'
//                 // bat 'mvn --version'
//                 // bat 'node --version'
//                 bat 'docker version'
//                 echo "Build"
//                 echo "PATH - $PATH"
//                 echo "BUILD_NUMBER - $env.BUILD_NUMBER"
//                 echo "BUILD_ID - $env.BUILD_ID"
//                 echo "JOB_NAME - $env.JOB_NAME"
//                 echo "BUILD_TAG - $env.BUILD_TAG"
//                 echo "BUILD_URL - $env.BUILD_URL"
//             }
//         }

//         stage('Test'){
//             steps {
//                 echo "Test"
//             }
//         }

//         stage('Integration TEst'){
//             steps {
//                 echo "Integration Test"
//             }
//         }
//     }  
    
//     post {
//         always {
//             echo 'I am Good . I always Run No Matter What'
//         }
//         success {
//             echo "I RUn only when you are successfull"
//         }
//         failure {
//             echo "I Only Run When You Fails the BUild"
//         }

//         changed {                             // means when status changed 
//             echo  "status is changed either fail to success or success to fail"
//         }              
//     }

// }









//DECLARATIVE

pipeline {
     agent any
    // agent { docker { image  'maven:3.6.3'} }
    // agent { docker { image  'node:13.8'} }
    environment {
        dockerHome = tool 'myDocker'
        mavenHome =  tool 'myMaven'
        PATH = "$dockerHome/bin:$mavenHome/bin:$PATH"
    }



    stages{
        stage('CheckOut') {
            steps {
                // sh 'mvn --version'
               
                bat 'cd'
                // sh 'pwd'
                // bat 'mvn --version'
                // bat 'node --version'
                bat 'docker version'
                echo "Build"
                echo "PATH - $PATH"
                echo "BUILD_NUMBER - $env.BUILD_NUMBER"
                echo "BUILD_ID - $env.BUILD_ID"
                echo "JOB_NAME - $env.JOB_NAME"
                echo "BUILD_TAG - $env.BUILD_TAG"
                echo "BUILD_URL - $env.BUILD_URL"
            }
        }

        stage('Compile'){
            steps {
                bat "mvn clean compile"
            }
        }


        stage('Test'){
            steps {
                bat "mvn test"
            }
        }

        stage('Integration TEst'){
            steps {
                bat "mvn failsafe:integration-test failsafe:verify"
            }
        }


        stage('Package'){
            steps {
                bat "mvn package -DskipTests"
            }
        }



         stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("zakriakhan/currency-exchange-devops:${env.BUILD_TAG}")
                }
            }
         }
        

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('','dockerhub'){
                    dockerImage.push();
                    dockerImage.push('latest');
                    }
                    
                }
            }
        }


    }  
    
    post {
        always {
            echo 'I am Good . I always Run No Matter What'
        }
        success {
            echo "I RUn only when you are successfull"
        }
        failure {
            echo "I Only Run When You Fails the BUild"
        }

        changed {                             // means when status changed 
            echo  "status is changed either fail to success or success to fail"
        }              
    }

}



