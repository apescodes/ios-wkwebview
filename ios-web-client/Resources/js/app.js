var urlParams = new URLSearchParams(window.location.search);

function onClickRefreshButton() {
    window.location.href = urlParams.get('app_url');
}