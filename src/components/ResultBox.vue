<template>
    <div class="container">
        <table class="table table-bordered new-table" width="100%">
            <thead>
                <tr>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(email, index) in emails" :key="index">
                    <td data-label="Name">
                        {{ email }}
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
export default {
    props: [
        'searchText'
    ],
    computed: {
        username: function () {
            return this.searchText.split('/')[0]
        },
        repository: function () {
            return this.searchText.split('/')[1]
        },
        emails: function () {
            return new Set(this.commits.map(c => c.commit.committer.email))
        }
    },
    methods: {
        getCommits: function () {
            
        
            this.nextLink = null
            fetch('https://api.github.com/repos/'+this.username+'/'+this.repository+'/commits').then(
                (resp) => {
                    let link = resp.headers.get('Link')
                    let raw_list = link.split('>; rel="next", ')
                    if (raw_list.length != 1) {
                        this.nextLink = raw_list[0].substr(1)
                        window.console.log(this.nextLink)
                    } else {
                        this.nextLink = null
                    }
                    window.console.log(this.nextLink)
                    
                    return resp.json()
                }
            ).then(
                (data) => data.forEach(
                    (d) => this.commits.push(d)
                )
            );
        
            
        }
    },
    data() {
        return {
            commits : [],
            nextLink: null
        }
    },
    watch: {
        searchText: function () {
            this.getCommits()
        },
        nextLink: function () {
            fetch(this.nextLink).then(
                (response) => {
                    let link = response.headers.get('Link')
                    if (link == null) {
                        window.console.log(response.url)
                        return
                    }
                    let raw_list = link.split('>; rel="next", ')
                    if (raw_list.length != 1) {
                        this.nextLink = raw_list[0].substr(1)
                    } else {
                        this.nextLink = null
                    }
                    
                    return response.json()
                }
            ).then(
                (data) => data.forEach(
                    (d) => this.commits.push(d)
                )
            );
        }
    },
}
</script>

<style>

</style>