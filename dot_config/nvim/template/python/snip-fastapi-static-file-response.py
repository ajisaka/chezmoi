@app.get('/content/{file_path:path}')
async def get_content(file_path: str, token: Token = Depends(authorize)) -> Response:
    resolved = (JSON_ROOT / file_path).resolve()
    if not resolved.is_relative_to(JSON_ROOT):
        return Response(status_code=404)
    return FileResponse(path=resolved)
