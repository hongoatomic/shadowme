$(document).ready(() => {

  const updateChat = (data, sender) => {
    const formatDate = (date) => {
      return `${date.getDay()}-${date.getMonth()}-${date.getFullYear()} ${date.getHours()}:${date.getMinutes()}`;
    };

    $('.chat-box').append(`
      <div class="chat-bubble-wrapper">
        <div class="chat-bubble ${sender}">
          <div class="chat-username">${data.identifier}</div>
          <div class="chat-message">${data.content}</div>
        </div>

        <div class="chat-timestamp  ${sender}">${formatDate(new Date(data.created_at))}</div>
      </div>
    `);
  };

  $('#chat-form').on('ajax:success', function(data) {
    $('#chat-form')[0].reset();
  });

  const pusher = new Pusher('0b12b52fd408ecfdf56b', {
    cluster: 'us2',
    encrypted: true
  });

  const chatChannel = pusher.subscribe('message');

  const notification = chat => {
    chatBtn = document.getElementById(`chat-booking-${chat.booking_id}`);
    if (chatBtn) {
      chatBtn.innerHTML = "(You have new messages)";
    }
  };

  const buildBookingStatus = booking => {
    if (booking.status == 'approved') {
      return (`
        <div>
          <span class="booking-category status-ap" style="text-transform: capitalize;">${booking.status}</span>
          <i class="fas fa-check-circle approved-status"></i>
        </div>
      `)
    } else {
      return (`
        <div>
          <span class="booking-category status-di" style="text-transform: capitalize;">${booking.status}</span>
          <i class="fas fa-times-circle declined-status"></i>
        </div>
      `)
    }
  }

  let booking_id = $('.chat-box').data("booking_id")
  let current_user = $('.chat-box').data("current_user")

  chatChannel.bind('new', function(data) {
    notification(data);
    let sender = data.user_id == current_user ? "me" : "him"
    if (data.booking_id == booking_id) {
      updateChat(data, sender);
      let chatBox = document.querySelector('.chat-box');
      chatBox.scrollTop = chatBox.scrollHeight - chatBox.clientHeight;
    }
  });

});