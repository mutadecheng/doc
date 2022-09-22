def inputData

pipeline { 
    agent none 

    stages { 
     stage('Stage 1') { 
      agent none 
      steps { 

       timeout(10) {
        script { 
         inputData = input message: 'Hello', ok: 'Proceed?', parameters: [string(defaultValue: '', description: 'text comment', name: 'comment')], submitterParameter: 'APPROVER' 
        } 
       } 
      } 
     } 
     stage('Stage 2') { 
      agent any 

      steps { 
       echo "the comment you texted is : ${inputData['comment']}" 
      } 
     } 
    } 
} 