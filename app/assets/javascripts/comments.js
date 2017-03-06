var TB = TB || {};

TB.CommentsModule = ( function() {

  var _getCommentsContainer = function(parentId, parentType) {
    var $parent = $(`[data-id="${parentId}"][data-type="${parentType}"]`);
    return $parent.find('.comments-container');
  };

  var _getComment = function(id) {
    return $(`[data-id="${id}"][data-type="Comment"]`);
  };

  var _clearForm = function($container) {
    var form = $container.find('.comment-form')[0];
    form.reset();
  };

  var addComment = function(parentId, parentType, comment) {
    var $container = _getCommentsContainer(parentId, parentType);
    var $comment = $(comment);
    $comment.prependTo($container).hide().slideDown('fast');
    _clearForm($container);
  };

  var removeComment = function(id) {
    var $comment = _getComment(id);
    $comment.slideUp('fast', function() {
      $(this).remove();
    });
  };

  return {
    addComment: addComment,
    removeComment: removeComment
  };

})();
