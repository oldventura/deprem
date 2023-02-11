<template>
    <div class="container p-4">
        <div class="card donations-card border-0">
            <div class="card-body p-0 border-0">
                <h3 class="text-white">Donation Links</h3>
                <hr class="text-white" />
                <div v-if="!donations.length" class="text-white rounded">
                    <mark><span class="fw-bold">Sonuç yok.</span></mark>
                </div>
                <div class="row g-4">
                    <div class="col-12 col-md-6 col-lg-4 col-xl-3" v-for="donation in donations">
                        <Donation :data="donation" @share="show_share(donation)" />
                    </div>
                </div>
                <div class="mt-4">
                    <ul class="list-group">
                        <li class="list-group-item bg-light">
                            <h5 class="fw-bold text-decoration-underline m-0">Payment Methods</h5>
                        </li>
                        <li class="list-group-item bg-dark text-white">
                            <span class="bi bi-bank2"></span>
                            <span class="ms-2">Bank</span>
                        </li>
                        <li class="list-group-item bg-dark text-white">
                            <span class="bi bi-credit-card-fill"></span>
                            <span class="ms-2">Credit Card</span>
                        </li>
                        <li class="list-group-item bg-dark text-white">
                            <span class="bi bi-currency-bitcoin"></span>
                            <span class="ms-2">Crypto</span>
                        </li>
                        <li class="list-group-item bg-dark text-white">
                            <span class="bi bi-paypal"></span>
                            <span class="ms-2">PayPal</span>
                        </li>
                        <li class="list-group-item bg-dark text-white">
                            <span class="bi bi-phone-fill"></span>
                            <span class="ms-2">Phone</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <Share ref="share" :key="share_key" @modal_hidden="share_key++" />
</template>

<script setup>
import { ref, onMounted } from 'vue';
import Donation from "./Donation.vue";
import Share from "./Share.vue";

import archive from "/assets/archive.json";
import { store } from "/js/store.js";
import Fuse from 'fuse.js';

const donations = ref([]);

const share_key = ref(0);
const fuse = ref(null);
const share = ref(null);

async function show_share(donation) {
    share.value.set(donation);
    share.value.show(donation);
}

async function _search(query) {
    if (query.length == 0) {
        donations.value = archive.donations.filter(donation => donation.lang === store.lang);
        return;
    }

    let result = fuse.value.search(query);
    donations.value = result.map(item => item.item);
}

defineExpose({
    search: _search
})

onMounted(() => {
    store.lang = navigator.language.split("-")[0].toUpperCase();
    donations.value = archive.donations;

    fuse.value = new Fuse(donations.value, {
        keys: ['name'],
        threshold: 0.3
    });
})
</script>