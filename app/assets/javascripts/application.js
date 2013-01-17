// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
  $(document).on('click','#save',function(){onclick_save()});
  $(document).on('click','.delete',function(){onclick_delete($(this))});
  $(document).on('input','#english',function(){search()});
  $(document).on('click','.edit',function(){onclick_edit($(this))});
  $(document).on('click','.cancel',function(){onclick_cancel($(this))});
  $(document).on('click','.update',function(){onclick_update($(this))});

  $(document).on('click','#add_category',function(){onclick_add()});
  $(document).on('click','.category',function(){onclick_category($(this))});
});

function onclick_add(item){

  $.ajax({
        url: '/categories',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ category: { name: $('#category_name').val() }}),
        success: function(data){
          $('ul').replaceWith(data);
          $('#category_name').val("");
        },
  });
}

function onclick_save(){
  var json =  '{"english":"' + $('#english').val() + '",';
  json += '"english_meaning":"'  + $('#english_meaning').val()  + '",';
  json += '"japanese_meaning":"' + $('#japanese_meaning').val() + '"}';
  $.ajax({
        url: '/main/update_word',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        data: json,
        success: function(data){
          $('ul').replaceWith(data);
          $('#english').val("");
          $('#english_meaning').val("");
          $('#japanese_meaning').val("");
        },
  });
}

function onclick_update(item){
  var li = item.parent('li');
  var english          = li.children('input.english').val();
  var english_meaning  = li.children('input.english_meaning').val();
  var japanese_meaning = li.children('input.japanese_meaning').val();

  var json =  '{"english":"' + english + '",';
  json += '"english_meaning":"'  + english_meaning  + '",';
  json += '"japanese_meaning":"' + japanese_meaning + '"}';
  $.ajax({
        url: '/main/update_word',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        data: json,
        success: function(data){
        },
  });

  onclick_cancel(item);
}

function onclick_cancel(item){
  var li = item.parent('li');
  li.children('input.english').attr('readonly',true);
  li.children('input.english_meaning').attr('readonly',true);
  li.children('input.japanese_meaning').attr('readonly',true);

  li.children('input.english').addClass('noedit');
  li.children('input.english_meaning').addClass('noedit');
  li.children('input.japanese_meaning').addClass('noedit');

  li.children('input.edit').css('display','');
  li.children('.update').remove();
  li.children('.cancel').remove();
}

function onclick_edit(item){
  var li = item.parent('li');
  li.children('input.english').attr('readonly',false);
  li.children('input.english_meaning').attr('readonly',false);
  li.children('input.japanese_meaning').attr('readonly',false);

  li.children('input.english').removeClass('noedit');
  li.children('input.english_meaning').removeClass('noedit');
  li.children('input.japanese_meaning').removeClass('noedit');

  var update = '<input class="update" type="submit" value="update">';
  var cancel = '<input class="cancel" type="submit" value="cancel">';
  li.children('input.edit').css('display','none');
  li.append(update);
  li.append(cancel);
}

function onclick_delete(item){
  var id = item.parent('li').attr('word_id');
  $.ajax({
        url: '/main/delete_word/' + id,
        success: function(data){
          $('ul').replaceWith(data);
        },
  });
}

function onclick_category(item){
  var id = item.parent('li').attr('category_id');
  $.ajax({
        url: '/main/category/' + id,
        success: function(data){
alert(data);
          $('ul').replaceWith(data);
        },
  });
}

function search(){
  var json =  '{"english":"' + $('#english').val() + '"}';
  $.ajax({
        url: '/main/search_word',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        data: json,
        success: function(data){
          $('ul').replaceWith(data);
        },
        error: function(jqXHR, textStatus, errorThrown){
          alert(textStatus);
        }
  });
}
