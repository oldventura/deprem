<template>
    <div class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Paylaş</h5>
                    <button type="button" class="btn-close" aria-label="Close" data-bs-dismiss="modal"
                        @click="emit('modal_hidden')"></button>
                </div>
                <div class="modal-body">
                    <div id="photo-div" class="d-flex justify-content-center align-items-center mb-4">
                        <div v-if="data_loaded" id="photo"
                            class="img-share-1 d-flex justify-content-center align-items-center">
                            <div class="img-share-2 d-flex flex-column border border-light border-3 p-2">
                                <h3 class="text-center text-white fw-bold">Türkiye'ye Deprem Bağışı</h3>
                                <div class="d-flex flex-column justify-content-between text-white text-center fw-bold p-2"
                                    style="flex: 1 1 auto;">
                                    <p>Yüz binlerce insan 7.8 büyüklüğündeki depremden etkilenmiş durumda. Onların
                                        hayat mücadeleleri sürerken bu zor zamanda her türlü desteğe ihtiyacımız var.
                                    </p>
                                    <div class="d-flex flex-column justify-content-center">
                                        <h5 class="fw-bold">{{ data.name }}</h5>
                                        <mark><span>{{ data.link }}</span></mark>
                                        <div>
                                            <div class="d-inline-flex">
                                                <div v-show="data.options.includes('bank')" class="m-2">
                                                    <span class="bi bi-bank2"></span>
                                                </div>
                                                <div v-show="data.options.includes('card')" class="m-2">
                                                    <span class="bi bi-credit-card-fill"></span>
                                                </div>
                                                <div v-show="data.options.includes('crypto')" class="m-2">
                                                    <span class="bi bi-currency-bitcoin"></span>
                                                </div>
                                                <div v-show="data.options.includes('paypal')" class="m-2">
                                                    <span class="bi bi-paypal"></span>
                                                </div>
                                                <div v-show="data.options.includes('phone')" class="m-2">
                                                    <span class="bi bi-phone-fill"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-white text-center">
                                        <p class="fw-bolder">Geç kalmadan sen de bağışta bulun!</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <p class="fw-bold">Görselin üzerine basılı tutarak da paylaşma seçeneklerine ulaşabilirsin.</p>
                    </div>
                    <hr />
                    <div v-if="data_loaded" class="d-flex flex-column mb-2">
                        <h5 class="fw-bold">{{ data.name }}</h5>
                        <mark><span>{{ data.link }}</span></mark>
                    </div>
                    <hr />
                    <div v-if="photo_loaded" class="d-flex flex-column justify-content-center">
                        <button type="button" class="btn btn-dark m-1" @click="copy_link">Adresi Kopyala</button>
                        <button type="button" class="btn btn-dark m-1" @click="share">Görseli Paylaş</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>


<script setup>
import { onMounted, ref } from 'vue';
import { Modal } from 'bootstrap';
import html2canvas from 'html2canvas';

const emit = defineEmits(['modal_hidden']);

const modal = ref(null);

const img = ref(null);
const data = ref(null);
const data_loaded = ref(false);
const photo_loaded = ref(false);

async function copy_link() {
    await navigator.clipboard.writeText(data.value.link);
}

async function share() {
    if (!navigator.share) {
        let a = document.createElement("a");
        a.href = img.value;
        a.download = "deprem-bagisi.png";
        a.click();
        return;
    }

    let base64url = img.value;
    let blob = await (await fetch(base64url)).blob();
    let file = new File([blob], 'deprem-bagisi.png', { type: blob.type });
    navigator.share({
        files: [file],
        title: "Türkiye'ye Deprem Bağışı",
        text: "Yüz binlerce insan 7.8 büyüklüğündeki depremden etkilenmiş durumda. Onların hayat mücadeleleri sürerken bu zor zamanda her türlü desteğe ihtiyacımız var.",
        url: data.value.link,
    });
}

function convert_div() {
    let el = document.querySelector("#photo");
    html2canvas(el, {
        width: 400,
        height: 400,
    }).then((canvas) => {
        let data = canvas.toDataURL("image/png");
        document.querySelector("#photo-div").innerHTML = `<img id="photo-img" class="img-fluid" src=${data}>`;
        img.value = data;
        photo_loaded.value = true;
    })
    return;
}

async function _show() {
    modal.value.show();
}

defineExpose({
    show: _show,
    set: (d) => {
        data.value = d;
        data_loaded.value = true;
    },
})

onMounted(() => {
    modal.value = new Modal(document.querySelector('.modal'), {
        keyboard: false,
        backdrop: 'static',
    });

    document.querySelector('.modal').addEventListener('shown.bs.modal', () => {
        convert_div();
    });
})
</script>