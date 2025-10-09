use leptos::*;
use leptos_meta::*;
use leptos_router::*;
use serde::{Deserialize, Serialize};
use surrealdb::sql::Thing;

#[component]
pub fn App() -> impl IntoView {
    provide_meta_context();

    view! {
        <Html lang="en" dir="ltr" attr:data-theme="light"/>
        <Title text="FollowTheTone - Guitar Database"/>
        <Meta charset="utf-8"/>
        <Meta name="viewport" content="width=device-width, initial-scale=1"/>
        <Meta name="description" content="Guitar database and catalog"/>

        <Router>
            <nav class="navbar bg-base-100 shadow-lg">
                <div class="flex-1">
                    <a class="btn btn-ghost text-xl" href="/">
                        "FollowTheTone"
                    </a>
                </div>
                <div class="flex-none">
                    <ul class="menu menu-horizontal px-1">
                        <li><a href="/">"Home"</a></li>
                        <li><a href="/guitars">"Guitars"</a></li>
                    </ul>
                </div>
            </nav>

            <main class="container mx-auto px-4 py-8">
                <Routes>
                    <Route path="/" view=HomePage/>
                    <Route path="/guitars" view=GuitarsListPage/>
                    <Route path="/guitars/:id" view=GuitarDetailPage/>
                </Routes>
            </main>
        </Router>
    }
}

#[component]
fn HomePage() -> impl IntoView {
    view! {
        <div class="hero min-h-screen bg-base-200">
            <div class="hero-content text-center">
                <div class="max-w-md">
                    <h1 class="text-5xl font-bold">"FollowTheTone"</h1>
                    <p class="py-6">
                        "Your comprehensive guitar database and catalog.
                        Explore detailed information about guitars, their specifications, and more."
                    </p>
                    <a class="btn btn-primary" href="/guitars">
                        "Browse Guitars"
                    </a>
                </div>
            </div>
        </div>
    }
}

#[derive(Serialize, Deserialize, Debug, Clone)]
struct Guitar {
    pub id: Option<Thing>,
    pub brand: String,
    pub model: String,
    #[serde(default)]
    pub body_style: String,
    #[serde(default)]
    pub line: String,
    #[serde(default)]
    pub variant: String,
    #[serde(default)]
    pub year_reference: String,
    #[serde(default)]
    pub weight: String,
    #[serde(default)]
    pub price_cents: i64,
    #[serde(default)]
    pub price_currency: String,
    #[serde(default)]
    pub serial_number: String,
}

#[component]
fn GuitarsListPage() -> impl IntoView {
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

#[component]
fn GuitarDetailPage() -> impl IntoView {
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
