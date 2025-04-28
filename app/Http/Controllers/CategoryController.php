<?php

namespace App\Http\Controllers;

use App\Models\Account;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\View\View;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): View
    {
        $categories = Category::All();
        return view('category.index', compact('categories'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(): View
    {
        return view('category.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
      $request->validate([
          'name' => ['required', 'string', 'max:255', 'unique:categories'],
          'descriptions' => 'required',
      ]);

      Category::create([
          'name'    => $request->get('name'),
          'descriptions'    => $request->get('descriptions')
      ]);

      return redirect()->route('category')->with('success', 'Selamat, Data berhasil di tambahkan!');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
      $category = Category::find($id);
      return view('category.edit', compact('category'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
      $request->validate([
          'name'          => [
              'required', 'string', 'max:255',
              Rule::unique('categories', 'name')->ignore($id),
          ],
          'descriptions'  => ['nullable', 'string']
      ]);

      $category = Category::findOrFail($id);
      $category->update([
          'name'          => $request->input('name'),
          'descriptions'  => $request->input('descriptions'),
      ]);

      return redirect()->route('category')->with('success', 'Data Berhasil diubah');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
      $category = Category::find($id);
      $category->delete();

      return redirect()->route('category')->with('success', 'Data Berhasil dihapus!');
    }
}
