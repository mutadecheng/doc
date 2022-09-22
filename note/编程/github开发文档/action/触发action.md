> https://docs.github.com/cn/actions/using-workflows/triggering-a-workflow
> https://docs.github.com/en/rest/reference/repos#create-a-repository-dispatch-event
> https://p3terx.com/archives/github-actions-manual-trigger.html


curl -X POST https://api.github.com/repos/serset/doc/dispatches \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token {有repo权限的Personal access token}" \
    --data '{"event_type": "commit-pages-doc"}' -w %{http_code}


