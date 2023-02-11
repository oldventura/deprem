<template>
    <nav class="bg-navbar">
        <div class="container p-4">
            <div class="d-flex justify-content-between mb-2">
                <div>
                    <span class="text-white fw-bold">Deprem Bağışı 🇹🇷</span>
                </div>
                <div class="dropdown">
                    <button type="button" class="btn btn-light dropdown-toggle bi bi-translate"
                        data-bs-toggle="dropdown" aria-expanded="false"></button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" @click="set_lang('TR')">🇹🇷 TR</a></li>
                        <li><a class="dropdown-item" @click="set_lang('EN')">🇺🇸 EN</a></li>
                        <li><a class="dropdown-item" @click="set_lang('DE')">🇩🇪 DE</a></li>
                    </ul>
                </div>
            </div>
            <div class="input-group flex-nowrap">
                <span class="input-group-text bi bi-search" id="basic-addon1"></span>
                <input ref="query" type="text" class="form-control" placeholder="Ara..." aria-label="Search"
                    aria-describedby="basic-addon1" @input="search">
            </div>
        </div>
    </nav>
    <div class="flex-view">
        <Home ref="home" />
    </div>
</template>

<script setup>
import { ref } from 'vue';
import Home from "./Home.vue";
import { store } from "/js/store.js";
import { Dropdown } from 'bootstrap';

const home = ref(null);
const query = ref(null);

function set_lang(lang) {
    store.lang = lang;
    home.value.search("");
}

async function search() {
    home.value.search(query.value.value);
}
</script>