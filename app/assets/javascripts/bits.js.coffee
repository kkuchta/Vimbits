# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$( () ->
    $('.bit .upvote').click( (e)-> vote($(this).attr('bit_id'),'up') )
    $('.bit .downvote').click( (e)-> vote($(this).attr('bit_id'),'down') )
    if( typeof allTags != 'undefined')
        console.log 'defining tagbox'
        $('.tagBox').textext {
            plugins : 'prompt autocomplete suggestions tags',
            prompt : 'add tags...',
            suggestions: allTags,
            tagsItems: window.oldTags
        }
        $singleTagBox = $('.singleTagBox')
        textext = $singleTagBox.textext {
            plugins : 'prompt autocomplete suggestions',
            prompt : 'Tag search...',
            suggestions: allTags
        }

    #$('.tag-search-button').click{

        #return false;
    #}

    $('.singleTagBox').keyup( (e)->
        code = if e.keyCode then e.keyCode else e.which
        if code == 13
            e.preventDefault()
            form = $(this).parents("form:first")
            form.submit()
    )

)

vote = (id, direction) ->
    console.log( 'voting ' + direction )
    if (direction == 'up' || direction == 'down')
        console.log( 'voting2' )
        $.ajax(
            # Yeah, yeah, violating hateoas here, will fix later.
            url: '/bits/' + id + '/votes'
            type: 'put'
            data: { direction: direction }
            success: () -> window.location.reload()
        )
