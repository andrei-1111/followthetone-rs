use crate::components::{GuitarDetailPage, GuitarsListPage, HomePage, Layout};
use leptos::*;
use leptos_meta::*;
use leptos_router::*;

#[component]
pub fn App() -> impl IntoView {
    provide_meta_context();

    view! {
        <Router>
            <Layout>
                <Routes>
                    <Route path="/" view=HomePage/>
                    <Route path="/guitars" view=GuitarsListPage/>
                    <Route path="/guitars/:id" view=GuitarDetailPage/>
                </Routes>
            </Layout>
        </Router>
    }
}
