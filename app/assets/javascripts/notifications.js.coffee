class Notifications
    constructor: ->
        @notifications = $("[data-behavior='notifications']")
        @setup() if @notifications.length > 0

    setup: ->
        $.ajax(
            url: "/notifications.json"
            dataType: "JSON"
            method: "GET"
            success: @handleSuccess
        )

    handleSuccess: (data) =>
        console.log(data)
        items = $.map data, (notification) ->
            "<a class='dropdown-item' href='#'>#{notification.action} #{notification.notifiable.type}</a>"

        $("[data-behavior='notification-items']").html(items)

jQuery ->
    new Notifications
