#! /usr/bin/env -S brew ruby
curl = "curl --location --fail --silent --show-error"

owner = ENV["GITHUB_REPOSITORY_OWNER"]
#owner ||= Pathname(`git -C '#{__dir__}' ls-remote --get-url`).parent.basename
owner ||= GitHub.user["login"]

return p owner

api = "https://api.github.com/users/#{owner}/gists"

gists = JSON.parse `#{curl} #{api}`, symbolize_names: true

gists.each do |git_pull_url:, files:, **| #id:,
  name = File.basename files.map(&:first).first.to_s, ".*"
  system "git submodule add #{git_pull_url} #{name}" #{id}"
end

# TODO
# .github/workflows as submodule?

=begin
#! /bin/zsh --no-rcs #/usr/bin/env act
alias curl='curl --location --fail --silent --show-error'
alias yq='yq --prettyPrint'

git ls-remote --get-url | read
: ${GITHUB_REPOSITORY_OWNER:=$REPLY:h:t:r}

curl https://api.github.com/users/$GITHUB_REPOSITORY_OWNER/gists |
yq '.[]' | while read #.[].git_pull_url, .[].files.[].filename
do
  yq .git_pull_url <<< $REPLY
  #yq '.git_pull_url' <<< $REPLY
  #git submodule add $REPLY:r &
  #git submodule update --recursive --init --remote
done
=end
