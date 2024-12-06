const typingForm = document.querySelector(".typing-form");
const chatList = document.querySelector(".chat-list");
const suggestion = document.querySelectorAll(".suggestion-list .suggestion");
const toggleThemeButton = document.querySelector("#toggle-theme-button");
const deleteChatButton = document.querySelector("#delete-chat-button");

let userMesssage = null;
let isResponseGenerating = false;

//API configuration
  const API_KEY = " AIzaSyD1q6RZ4Vi9WMvmEonaZlinJRXjSQcEF7k ";
  const API_URL =  `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=${API_KEY}`;


  const loadLocalStorageData = () => {
    const savedChats = localStorage.getItem("savedChats");
    const isLightMode = (localStorage.getItem("themeColor") === "light_mode");

//apply the storage theme
    document.body.classList.toggle("light_mode", isLightMode);
    toggleThemeButton.innerText = isLightMode ? "dark_mode" : "light_mode";

//restore saved chats
    chatList.innerHTML = savedChats || "";

    document.body.classList.toggle("hide-header", savedChats);
    chatList.scrollTo(0, chatList.scrollHeight); // scroll to the bottom
  }

  
  loadLocalStorageData();
  
//CREATE A NEW MESSAGE ELEMENT AND RETURN IT
const createMessageElement = (content, ...classes) => {
    const div = document.createElement("div");
    div.classList.add("message", ...classes);
    div.innerHTML = content;
    return div;
}

//show typing effect b displaying words one by one
const showTypingEffect = (text, textElement, incomingMessageDiv) => {
  const words = text.split(' ');
  let currentWordIndex = 0;

  const typingInterval = setInterval(() => {
  //Append each word to the text element with space
    textElement.innerText += (currentWordIndex === 0 ? '' : ' ') + words[currentWordIndex++];
    incomingMessageDiv.querySelector(".icon").chatList.add("hide");

    //if all words are displayed
    if(currentWordIndex === words.length ){
      clearInterval(typingInterval);
      isResponseGenerating = false;
      incomingMessageDiv.querySelector(".icon").chatList.remove("hide");
      localStorage.setItem("savedChats", chatList.innerHTML); //save chats to local storage
    }
      chatList.scrollTo(0, chatList.scrollHeight); // scroll to the bottom 
  }, 70 );
}

//fetch responses from the api based on user message
const generateAPIResponse = async (incomingMessageDiv) => { 
  const textElement =  incomingMessageDiv.querySelector(".text");//Get text element
  
  

   try {
    //send a post request to the API with the users message
     const response = await fetch(API_URL, {
       method: "POST",
        headers: {"Content-Type": "application/json"},
       body: JSON.stringify({
            contents:[{
                role:"user",
               parts: [{ text: userMesssage}]
           }]
        })
      });

      const data = await response.json();
      if(!response.ok) throw new Error(data.error.message);

     //get the api response text and remove asterisks from it
      const apiResponse = data?.candidates[0].content.parts[0].text.replace(/\*\*(.*?)\*\*/g, '$1');
      showTypingEffect(apiResponse, textElement, incomingMessageDiv);
    }catch (error) {
      isResponseGenerating = false;
       textElement.innerText = error.message;
       textElement.chatList.add("error");
    }finally{
      incomingMessageDiv.classList.remove("loading");
    }

}
//show Loading Animation while waiting for api response
const showLoadingAnimation = () => {
    const html = ` <div class="message-content">
    <img src="../imges/Gemini logo.webp" alt="" class="avatar">
    <p class="text"></p>
      
    <div class="loading-indicator">
                <div class="loading-bar"></div>
                <div class="loading-bar"></div>
                <div class="loading-bar"></div>
                </div>
              </div>
      <span onclick="copyMessage(this)" class=" icon material-symbols-rounded  ">content_copy</span>`;

const incomingMessageDiv = createMessageElement(html, "incoming", "loading");
chatList.appendChild(incomingMessageDiv);

chatList.scrollTo(0, chatList.scrollHeight); // scroll to the bottom
generateAPIResponse(incomingMessageDiv);
}

//copy message text to the clipboard
const copyMessage = (copyIcon) => {
  const messageText = copyIcon.parentElement.querySelector(".text").innerText;
  navigator.clipboard.writeText(messageText);
  copyIcon.innerText = "done";
  setTimeout(() => copyIcon.innerText = "content_copy", 1000);
}

//handle sending outgoing chat message
const handleOutgoingChat = () => {
    userMesssage = typingForm.querySelector(".typing-input").value.trim() || userMesssage;
    if(!userMesssage || isResponseGenerating) return; //exit if there is no message

    isResponseGenerating = true;

    const html = ` <div class="message-content">
           <img src="../imges/question image.png" alt="" class="avatar">
           <p class="text"></p>
      </div> `;

      const outgoingMessageDiv = createMessageElement(html, "outgoing");
      outgoingMessageDiv.querySelector(".text").innerText = userMesssage;
      chatList.appendChild(outgoingMessageDiv);


      typingForm.reset();// clear input field
      chatList.scrollTo(0, chatList.scrollHeight); // scroll to the bottom
      document.body.classList.add("hide-header");//hide the header once chat starts
      setTimeout(showLoadingAnimation, 450);
}

//set userMessage and handle outgoing chat when a suggestion is clicked
suggestion.forEach( suggestion => {
  suggestion.addEventListener("click", () => {
     userMesssage = suggestion.querySelector(".text").innerText;
     handleOutgoingChat();
  });
});

//toggle light and dark themes
toggleThemeButton.addEventListener("click", () => {
  const isLightMode = document.body.classList.toggle("light_mode");
  localStorage.setItem("themeColor", isLightMode ? "light_mode" : "dark_mode");
  toggleThemeButton.innerText = isLightMode ? "dark_mode" : "light_mode";
});

//delete all chats from local storage when button is clicked
deleteChatButton.addEventListener("click", () => {
  if(confirm("Are you sure you want to delete all messages?")) {
    localStorage.removeItem("savedChats");
    loadLocalStorageData();
  }
});

//prevent default form submission and handle outgoing chat
typingForm.addEventListener("submit", (e) => {
    e.preventDefault();

    handleOutgoingChat();
});

