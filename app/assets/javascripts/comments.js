var TB = TB || {};

TB.CommentsModule = ( function() {

  var init = function() {
    _commentLinkListener();
    _cancelCommentLinkListener();
  };

  var _commentLinkListener = function() {
    $('.comment-link').click( function(event) {
      event.preventDefault();
      var $linkContainer = $(event.target).parent();
      var $form = $linkContainer.next();
      $linkContainer.slideUp('fast', function() {
        $form.slideDown('fast');
      });
    });
  };

  var _cancelCommentLinkListener = function() {
    $('.cancel-comment').click( function(event) {
      event.preventDefault();
      var $form = $(event.target).parent();
      var $linkContainer = $form.prev();
      $linkContainer.slideDown('fast');
      $form.slideUp('fast');
    });
  }

  var _getCommentsContainer = function(parentId, parentType) {
    var $parent = $('[data-id="' + parentId + '"][data-type="' + parentType + '"]');
    return $parent.find('.comments-container');
  };

  var _getComment = function(id) {
    return $('[data-id="' + id + '"][data-type="Comment"]');
  };

  var _clearForm = function($container) {
    console.log($container);
    var form = $container.siblings('.comment-form')[0];
    form.reset();
  };

  var addComment = function(parentId, parentType, comment) {
    var $container = _getCommentsContainer(parentId, parentType);
    var $comment = $(comment);
    $comment.appendTo($container).hide().slideDown('fast');
    _clearForm($container);
  };

  var removeComment = function(id) {
    var $comment = _getComment(id);
    $comment.slideUp('fast', function() {
      $(this).remove();
    });
  };

  return {
    init: init,
    addComment: addComment,
    removeComment: removeComment
  };

})();

$(document).ready( function() {
  TB.CommentsModule.init();
})
