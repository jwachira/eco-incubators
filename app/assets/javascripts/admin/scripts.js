/* profile-page: enable showing of social elements on thumbnail hover */
$('.thumbnail').hover(function(){
	$(this).find('.social-bar .pull-left').each(function(){
		$(this).fadeIn('fast');
	});
},
function(){
	$(this).find('.social-bar .pull-left').each(function(){
		$(this).fadeOut('fast');
	});
});
/* item-details: enable clicking on sizes, colors etc */
$('section#item-details div.sizes span, section#item-details div.colors span').click(function(){
	($(this).hasClass('selected')) ?
		($(this).removeClass('selected'))
		: ($(this).addClass('selected'));
});
/* item-details: enable tabs */
$('#item-details-tabs a').click(function (e) {
	e.preventDefault();
	$(this).tab('show');
});
/* item-details: verify size on button click */
$('button.addtocart').click(function(){
	$('div.success #item-title').text($('#item-title-major').data('title'));
	$('div.success #item-size').text($('div.sizes span.selected').data('gender') + '\'S ' + $('div.sizes span.selected').text());
	$('div.success #item-color').text('COLOR: ' + $('div.colors span.selected').data('color'));
	$('div.success #item-quantity').text('QUANTITY: ' + $('#item-quantity option:selected').text());
	($('div.sizes span').hasClass('selected')) ?
		($('.success').removeClass('hide'))
		: ($('div.warning').removeClass('hide'));
	$('div.success button.dismiss').click(function(){
		$(this).parent().parent().parent().fadeOut('slow');
	});
});
/* search-product: stylize checkboxes */
$('#search-top label span.c_off').click(function(){
	$(this).toggleClass('c_on');
	if ($(this).hasClass('c_on'))
	{
		$(this).parent().find('input').attr('checked','checked');
	}
	else
	{
		$(this).parent().find('input').removeAttr('checked');		
	}
});
/* div.sold-out: manage position */
$(document).ready(function(){
	if ($(window).width() > 1200)
		{
			$('div.sold-out').css('margin-left','257px');
			$('div.sold-out').css('right','auto');
		}
		else
		{
			if (($(window).width() > 979) && ($(window).width() <= 1200) )
			{
				$('div.sold-out').css('margin-left','188px');
				$('div.sold-out').css('right','auto');
			}
			else
			{
				if (($(window).width() >= 768) && ($(window).width() <= 979) )
				{
					$('div.sold-out').css('margin-left','115px');
					$('div.sold-out').css('right','auto');
				}
				else
				{
					if (($(window).width() < 768))
					{
						$('div.sold-out').css('margin-left','0px');
						$('div.sold-out').css('right','26px');
					}
				}
			}
		}
	$(window).resize(function(){
		if ($(window).width() > 1200)
		{
			$('div.sold-out').css('margin-left','257px');
			$('div.sold-out').css('right','auto');
		}
		else
		{
			if (($(window).width() > 979) && ($(window).width() <= 1200) )
			{
				$('div.sold-out').css('margin-left','188px');
				$('div.sold-out').css('right','auto');
			}
			else
			{
				if (($(window).width() >= 768) && ($(window).width() <= 979) )
				{
					$('div.sold-out').css('margin-left','115px');
					$('div.sold-out').css('right','auto');
				}
				else
				{
					if (($(window).width() < 768))
					{
						$('div.sold-out').css('margin-left','0px');
						$('div.sold-out').css('right','26px');
					}
				}
			}
		}
	});
});

//inbox: open or close the message box
$('div.message-title h3').click(function(){
	$(this).parent().parent().parent().parent().toggleClass('closed');
});

//inbox: remove message on close message
$('div.message-close').click(function(){
	$(this).parent().parent().parent().parent().detach();
})

//item-add: show 'Make primary' and 'Dismiss' on thumbnail hover
$('section#item-add ul.thumbnails li').hover(function(){
	$(this).find('a.thumbnail-primary, a.thumbnail-dismiss').toggleClass('hide');
})

//item-add: detach thumbnail li on 'Dismiss'
$('section#item-add a.thumbnail-dismiss').click(function(){
	$(this).parent().detach();
})

//item-add: onclick 'Make primary' add img to top li
$('section#item-add a.thumbnail-primary').click(function(){
	var srcWantedPrimary = $(this).parent().find('a.thumbnail img').attr('src');
	var srcAlreadyPrimary = $('section#item-add a.mainImage img').attr('src');
	$(this).parent().find('a.thumbnail img').attr('src', srcAlreadyPrimary);
	$('section#item-add a.mainImage img').attr('src', srcWantedPrimary);
})