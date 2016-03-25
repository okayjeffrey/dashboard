class Dashing.Huebutton extends Dashing.Widget
    onData: (data) ->
        $(@node).css('border-color', @get('bg_color'))
        $(@node).addClass(@get('state'))
