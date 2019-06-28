function git_prompt_info {
  git_prompt_vars
  GIT_TOGETHER=$(echo $(git config --global git-together.active))
  echo -e " $GIT_TOGETHER$SCM_PREFIX$SCM_BRANCH$SCM_STATE$SCM_SUFFIX"
}
