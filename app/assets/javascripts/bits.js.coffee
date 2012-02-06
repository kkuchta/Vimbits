# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$( () ->
    $('.bit .upvote').click( (e)-> vote($(this).attr('bit_id'),'up') )
    $('.bit .downvote').click( (e)-> vote($(this).attr('bit_id'),'down') )
)

vote = (id, direction) ->
    console.log( 'voting ' + direction )
    if (direction == 'up' || direction == 'down')
        console.log( 'voting2' )
        $.ajax(
            url: '/bits/' + id + '/votes'
            type: 'put'
            data: { direction: direction }
            success: () -> window.location.reload()
        )
