use leptos::*;
use leptos_router::*;

#[component]
pub fn GuitarDetailPage() -> impl IntoView {
    let params = use_params_map();
    let id = move || params.with(|params| params.get("id").cloned().unwrap_or_default());

    view! {
        <div class="py-8">
            <h1 class="text-4xl font-bold mb-8">
                {move || format!("Guitar Details - {}", id())}
            </h1>
            <div class="card bg-base-100 shadow-xl">
                <div class="card-body">
                    <h2 class="card-title">"Guitar Information"</h2>
                    <p>"Loading guitar details..."</p>
                    <div class="card-actions justify-end">
                        <a class="btn btn-secondary" href="/guitars">"Back to List"</a>
                    </div>
                </div>
            </div>
        </div>
    }
}
