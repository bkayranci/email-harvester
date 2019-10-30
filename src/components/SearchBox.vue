<template>
    <div class="container">
      <div class="row">
        <div class="col-sm-12 mb-3">
          <b-input-group class="mt-3">
            <b-form-input placeholder="bkayranci" v-model="username" v-on:keyup.enter="searchUser"></b-form-input>
            <b-input-group-append>
              <b-button variant="success" @click="searchUser">&#10170;</b-button>
            </b-input-group-append>
          </b-input-group>
        </div>
      </div>
      <div class="row" v-if="user">
        <div class="col-12">
          <b-row class="mb-3">
            <b-col>
              <b-card no-body class="overflow-hidden">
                <b-row no-gutters>
                  <b-col md="3">
                    <b-card-img :src="user.avatar_url" class="rounded-0"></b-card-img>
                  </b-col>
                  <b-col md="9">
                    <b-card-body :title="user.name">
                      <b-card-text>
                        {{ user.bio }}
                      </b-card-text>
                      <b-button :href="user.html_url" variant="success">
                        Github
                      </b-button>
                    </b-card-body>
                  </b-col>
                </b-row>
              </b-card>
            </b-col>
          </b-row>
        </div>
      </div>
      <b-modal v-model="modalShow" title="Email List">
        <p>Click to send email</p>
        <b-list-group>
          <b-list-group-item :href="`mailto:${email}`" v-for="(email, index) in uniqueEmails" :key="index">{{ email }}</b-list-group-item>
        </b-list-group>
      </b-modal>
      <div class="row" id="repos" v-if="user">
        <div class="col-3 mb-3" v-for="(repo, index) in repos" :key="index">
          <b-card :title="repo.name" header-tag="header" footer-tag="footer" style="min-height: 450px">
            <b-card-text>{{ repo.description }}</b-card-text>
            <template v-slot:footer>
              <b-button variant="primary" class="btn-block" @click="searchEmails(repo)">
                Scan
              </b-button>
            </template>
          </b-card>
        </div>
      </div>
    </div>
</template>

<script>
import { BInputGroup, BInputGroupAppend, BButton } from 'bootstrap-vue'

export default {
  components: {
    'b-input-group': BInputGroup,
    'b-input-group-append': BInputGroupAppend,
    'b-button': BButton
  },
  data() {
    return {  
      username: 'bkayranci',
      repos: [],
      user: null,
      modalShow: false,
      emails: [],
      commits: []
    }
  },
  watch: {
    'user.repos_url': function () {
      this.searchRepos()
    }
  },
  computed: {
    uniqueEmails: function () {
      return new Set(this.commits.map(c => c.commit.committer.email))
    }
  },
  methods: {
    searchUser: function () {
      let self = this
      fetch(`https://api.github.com/users/${self.username}`).then((response) => response.json()).then((user) => self.user = user
      ).catch((error) => {
        window.console.log(error)
      })
    },
    searchRepos: function () {
      let self = this
      fetch(`${self.user.repos_url}`).then((response) => response.json()).then((repos) => self.repos = repos
      ).catch((error) => {
        window.console.log(error)
      })
    },
    searchEmails: function (repo) {
      let self = this
      self.modalShow = true
      fetch(`https://api.github.com/repos/${repo.full_name}/commits`).then((response) => response.json()).then((commits) => {
        self.commits = commits
      }
      ).catch((error) => {
        window.console.log(error)
      })
    },
    emitOnChange: function (data) {
      this.$emit('on-changed-search', data.target.value)
    }
  }
}
</script>

<style>
.container {
  padding: 10px;
}

ul li {
  list-style: none;
  
}
</style>