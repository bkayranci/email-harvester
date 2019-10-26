<template>
    <div>
        <form action="#" class="Search">
            <label for="search">
                Search
            </label>
            <input v-on:blur="emitOnChange" type="search" id="search" />
        </form>
    </div>
</template>

<script>
export default {
    data() {
        return {
            app: document.getElementById("app"),
            init: document.getElementById("init"),
            layer: document.getElementById("layer"),
            input: document.getElementById("inp-cover input"),
            button: document.getElementsByTagName("button"),
            user: {
                username: '',
                repository: ''
            }
        }
    },
    methods: {
        emitOnChange: function (data) {
            this.$emit('on-changed-search', data.target.value)
        }
    }
}
</script>

<style>
body {
  padding: 1rem;
}
hr {
  border: 1px dotted #bdc3c7;
}
.Search {
  display: flex;
}
.Search label {
  display: none;
}
.Search input {
  background: #ededed url("https://static.tumblr.com/ftv85bp/MIXmud4tx/search-icon.png") no-repeat 7.22px center;
  width: 34px;
  height: 34px;
  border-radius: 50%;
  border: none;
  outline: none;
  padding: 0 6px;
  font-size: 0px;
  cursor: pointer;
}
.Search input:focus {
  flex: 1;
  border-radius: 6px;
  padding: 0 6px 0 36px;
  font-size: 14px;
  cursor: text;
}

</style>