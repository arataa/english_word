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
  $(document).on('click','.word_list .delete',function(){onclick_delete($(this))});
  $(document).on('input','#word',function(){search()});
  $(document).on('click','.edit',function(){onclick_edit($(this))});
  $(document).on('click','.cancel',function(){onclick_cancel($(this))});
  $(document).on('click','.word_list .update',function(){onclick_update($(this))});

  $(document).on('click','#add_category',function(){onclick_add()});
  $(document).on('click','.category .delete',function(){onclick_category_delete($(this))});
  $(document).on('click','.category .update',function(){onclick_category_update($(this))});

  $(document).on('click','.category_name',function(){onclick_category($(this))});

  $(document).on('click','#category_id a',function(){onclick_category_all()});

   onpopstate = function(event) {
     changeContents(location.pathname);
   }


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
  var json = JSON.stringify({ word : {category_id : $('#category_id').attr('category_id'),
                                      word : $('#word').val(),
                                  meaning  : $('#meaning').val()}});
  $.ajax({
        url: '/words',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        data: json,
        success: function(data){
          $('ul').replaceWith(data);
          $('#word').val("");
          $('#meaning').val("");
        },
  });
}

function onclick_update(item){
  var li      = item.parent('li');
  var id      = li.attr('word_id');
  var word    = li.children('.word').val();
  var meaning = li.children('.meaning').val();

  var json = JSON.stringify({ word : {category_id : $('#category_id').attr('category_id'),
                                      word : word,
                                  meaning  : meaning }});
  $.ajax({
        url: '/words/' + id,
        type: 'PUT',
        contentType: "application/json; charset=utf-8",
        data: json,
        success: function(data){
        },
  });

  onclick_cancel(item);
}

function onclick_category_update(item){
  var li = item.parent('li');
  var id = li.attr('category_id');
  var category_name = li.children('input.category_name').val();

  $.ajax({
        url: '/categories/' + id,
        type: 'PUT',
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ category: { name: category_name }}),
        success: function(data){
        },
  });

  onclick_cancel(item);
}


function onclick_cancel(item){
  var li = item.parent('li');
  li.children('input[type=text]').attr('readonly',true);
  li.children('input[type=text]').addClass('noedit');
  li.children('textarea').attr('readonly',true);
  li.children('textarea').addClass('noedit');

  li.children('input.edit').css('display','');
  li.children('.update').remove();
  li.children('.cancel').remove();
}

function onclick_edit(item){
  var li = item.parent('li');
  li.children('input[type=text]').attr('readonly',false);
  li.children('input[type=text]').removeClass('noedit');
  li.children('textarea').attr('readonly',false);
  li.children('textarea').removeClass('noedit');

  var update = '<input class="update" type="submit" value="update">';
  var cancel = '<input class="cancel" type="submit" value="cancel">';
  li.children('input.edit').css('display','none');
  li.append(update);
  li.append(cancel);
}

function onclick_delete(item){
  var id = item.parent('li').attr('word_id');
  $.ajax({
        type: 'DELETE',
        url: '/words/' + id,
        success: function(data){
          $('ul').replaceWith(data);
        },
  });
}

function onclick_category_delete(item){
  var id = item.parent('li').attr('category_id');
  $.ajax({
        type: 'DELETE',
        url: '/categories/' + id,
        success: function(data){
          $('ul').replaceWith(data);
        },
  });
}

function onclick_category(item){
  //e.preventDefault();
  var id = item.parent('li').attr('category_id');
  var nextPage = '/categories/' + id;

  changeContents(nextPage);
  window.history.pushState(null, null, nextPage)
}


function onclick_category_all(){
  var nextPage = '/';
  changeContents(nextPage);
  window.history.pushState(null, null, nextPage)
}

function search(){
  var json = JSON.stringify({ category_id : $('#category_id').attr('category_id'),
                                  word  : $('#word').val()  });
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

function changeContents(url) {
  $('section').load(url+' section');
}
