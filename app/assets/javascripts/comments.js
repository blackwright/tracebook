var TB = TB || {};

TB.CommentsModule = ( function() {

  let _getCommentsContainer = (parentId, parentType) => {
    let $parent = $(`[data-id="${parentId}"][data-type="${parentType}"]`);
    return $parent.find('.comments-container');
  };

  let _getComment = (id) => {
    return $(`[data-id="${id}"][data-type="Comment"]`);
  };

  let _clearForm = ($container) => {
    let form = $container.find('.comment-form')[0];
    form.reset();
  };

  let addComment = (parentId, parentType, comment) => {
    let $container = _getCommentsContainer(parentId, parentType);
    let $comment = $(comment);
    $container.prepend($comment);
    _clearForm($container);
  };

  let removeComment = (id) => {
    let $comment = _getComment(id);
    $comment.remove();
  };

  return {
    addComment: addComment,
    removeComment: removeComment
  }

})();
