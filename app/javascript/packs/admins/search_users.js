$(document).on('turbolinks:load', () => {
    const $dropDown = $('.dropdown-users');
    const path = $('#search-path').val();

    $dropDown.click((event) => {
        const userId = event.target.getAttribute('data-user');
        $('#user_id').val(userId);
        const username = event.target.innerHTML;
        $dropDown.hide();
        $('.input-search>input').val(username);
    });
    $('.input-search>input').keypress((event) => {
        const keyword = event.target.value;
        $.get({
            url: path,
            data: { keyword },
            success: ({ users }) => {
                if (users.length === 0) {
                    $dropDown.hide();
                } else {
                    users.forEach((user) => {
                        $dropDown.html(`<span class="pl-2 d-block" data-user="${user.id}">${user.username}</span>`);
                    });
                    $dropDown.show();
                }
            },
        });
    });
});
