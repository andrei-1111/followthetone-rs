use crate::models::Guitar;
use leptos::*;

#[component]
pub fn GuitarsListPage() -> impl IntoView {
    let guitars = create_resource(
        || (),
        |_| async move {
            let response = reqwest::get("http://localhost:8080/api/guitars").await;
            match response {
                Ok(resp) => {
                    if resp.status().is_success() {
                        resp.json::<Vec<Guitar>>().await.unwrap_or_default()
                    } else {
                        vec![]
                    }
                }
                Err(_) => vec![],
            }
        },
    );

    view! {
        <div class="py-8">
            <h1 class="text-4xl font-bold mb-8">"Guitar Collection"</h1>
            <Suspense fallback=move || view! { <div class="loading loading-spinner loading-lg"></div> }>
                {move || {
                    guitars.get().map(|guitars| {
                        if guitars.is_empty() {
                            view! {
                                <div class="alert alert-warning">
                                    <span>"No guitars found. Please check your database connection."</span>
                                </div>
                            }
                        } else {
                            view! {
                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                                    {guitars.into_iter().map(|guitar| {
                                        let guitar_id = guitar.id.as_ref()
                                            .map(|id| format!("{}", id.id))
                                            .unwrap_or_default();

                                        view! {
                                            <div class="card bg-base-100 shadow-xl">
                                                <div class="card-body">
                                                    <h2 class="card-title">{format!("{} {}", guitar.brand, guitar.model)}</h2>
                                                    <p>{format!("Body Style: {}", guitar.body_style)}</p>
                                                    <p>{format!("Year: {}", guitar.year_reference)}</p>
                                                    <div class="card-actions justify-end">
                                                        <a class="btn btn-primary" href=format!("/guitars/{}", guitar_id)>"View Details"</a>
                                                    </div>
                                                </div>
                                            </div>
                                        }
                                    }).collect::<Vec<_>>()}
                                </div>
                            }
                        }
                    })
                }}
            </Suspense>
        </div>
    }
}
