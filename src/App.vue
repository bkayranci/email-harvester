<template>
  <div id="app">
    <SearchBox @on-changed-search="searchChanged" />
    <ResultBox :search-text="searchText" />
  </div>
</template>

<script>
import ResultBox from './components/ResultBox.vue'
import SearchBox from './components/SearchBox.vue'

export default {
  name: 'app',
  components: {
    ResultBox, SearchBox
  },
  data () {
    return {
      searchText: null
    }
  },
  methods: {
    searchChanged: function (searchText) {
      this.searchText = searchText
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
